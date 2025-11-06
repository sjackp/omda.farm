const bus = new EventTarget()

const EVENT_NAME = 'global-data-refresh'

export function emitGlobalRefresh() {
  bus.dispatchEvent(new Event(EVENT_NAME))
}

export function onGlobalRefresh(listener: () => void) {
  const handler = () => listener()
  bus.addEventListener(EVENT_NAME, handler)
  return () => bus.removeEventListener(EVENT_NAME, handler)
}


