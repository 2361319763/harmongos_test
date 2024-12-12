
export class ListDividerBorder {
  strokeWidth: Length = 1
  startMargin: Length = 60
  endMargin: Length = 0
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    strokeWidth && (this.strokeWidth = strokeWidth)
    startMargin > 0 && (this.startMargin = startMargin)
    endMargin > 0 && (this.endMargin = endMargin)
    color && (this.color = color)
  }
}