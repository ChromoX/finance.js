class AsyncManager
	constructor: (options) ->
		@options = options || { workers: 2 }
		@queue = []
		@callbacks = []
		@workers = []
		@asyncPossible = false
		@workerImplmentation = null
		if window? and window.Worker?
			@asyncPossible = true
			@workerImplmentation = window.Worker
		else if not window? and require?
			## Not complete detection
			@asyncPossible = true
			@workerImplmentation = (require 'webworker').Worker
			@options.workers = ((require 'os').cpus()).length
		
	push: (params, calculation, callback) ->	
		serializedData = JSON.stringify params.data
		serializedArgs = JSON.stringify params.args
		serializedCalculation = JSON.stringify calculation
		lookupID = Math.random()
		@queue.push {id: lookupID, data: serializedData, args: serializedArgs, calculation: serializedCalculation}
		@callbacks.push {id: lookupID, callback: callback}
		@process()
		return
		
	process: () ->
		if @queue.length == 0
			return
		workerStub = @findWorker()
		if !workerStub
			# No workers avilable right now
			return
		calculation = @queue.shift()
		workerStub.working = true
		workerStub.id = calculation.id
		workerStub.worker.postMessage(calculation)
	
	findWorker: (id) ->
		if id?
			for workerStub in @workers
				if workerStub.id == id
					return workerStub
		for workerStub in @workers
			if not workerStub.working
				return workerStub
		if @workers.length < @options.workers
			return @createWorker()
		return false
	
	findCallback: (id) ->
		if id?
			for callback in @callbacks
				if callback.id == id
					return callback
	
	createWorker: () ->
		if not @asyncPossible
			return false
		worker = new @workerImplmentation('calcthread.js')
		worker.onmessage = @_onMessage
		@workers.push {working: false, worker: worker}
		return @workers[@workers.length-1]

	_onMessage: (obj) =>
		obj = obj.data
		worker = @findWorker(obj.id)
		worker.working = false
		worker.id = null
		callbackObject = @findCallback(obj.id)
		callbackObject.callback(obj.answer)
		@process()