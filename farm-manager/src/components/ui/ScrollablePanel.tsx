import type { PropsWithChildren } from 'react'

type Props = PropsWithChildren<{
  maxHeight?: number | string
  className?: string
}>

export default function ScrollablePanel({ maxHeight = 320, className, children }: Props) {
  const style: React.CSSProperties = {
    maxHeight: typeof maxHeight === 'number' ? `${maxHeight}px` : maxHeight,
  }
  return (
    <div className={['overflow-auto', className].filter(Boolean).join(' ')} style={style}>
      {children}
    </div>
  )
}


