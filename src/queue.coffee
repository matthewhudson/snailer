class exports.Queue
  queue = []

  # Add item to end
  enqueue: (items) ->
    if Array.isArray(items)
      queue.push item for item in items
    else
      queue.push items

  # Remove item from the begining
  dequeue: () ->
    queue.shift()

  # Read the first item
  peek: () ->
    queue[0] 

  # Get the queue length
  length: () ->
    queue.length
