export { }
import * as React from 'react'
import { cn } from '@/lib/utils'

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: 'default' | 'outline' | 'ghost' | 'destructive'
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'default', ...props }, ref) => {
    const variantClass =
      variant === 'outline'
        ? 'border border-[#6B7A3A] text-[#5F6D3A] hover:bg-[#6B7A3A]/10'
        : variant === 'ghost'
        ? 'bg-transparent text-[#5F6D3A] hover:bg-[#6B7A3A]/10'
        : variant === 'destructive'
        ? 'bg-red-600 text-white hover:bg-red-700'
        : 'bg-[#6B7A3A] text-white hover:bg-[#5F6D3A]'

    return (
      <button
        ref={ref}
        className={cn(
          'inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-9 px-4 py-2',
          variantClass,
          className
        )}
        {...props}
      />
    )
  }
)
Button.displayName = 'Button'

export default Button
export { Button }
 