import { Badge } from '@/components/ui/badge'

import type { PersonStatus } from '../types'

type Props = {
  status: PersonStatus | null
}

const labels: Record<PersonStatus, string> = {
  active: 'Activo',
  inactive: 'Inactivo',
  archived: 'Archivado',
}

export function PersonStatusBadge({
  status,
}: Props) {
  if (!status) {
    return (
      <Badge variant="outline">
        Sin estado
      </Badge>
    )
  }

  return (
    <Badge>
      {labels[status]}
    </Badge>
  )
}