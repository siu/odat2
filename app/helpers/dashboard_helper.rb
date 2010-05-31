# encoding: UTF-8
module DashboardHelper
  def status_message(record)
    N_('Creado')
    N_('Modificado')
    record.created_at == record.updated_at ? "<span class=\"new-record\">#{_('Creado')}</span>" : "<span class=\"mod-record\">#{_('Modificado')}</span>"
  end

  def time_and_status_for(record)
    N_('%{status} hace %{time}') % { :status => '', :time => '' }

    '<small>' + _('%{status} hace %{time}') % { :status => status_message(record), :time => time_ago_in_words(record.updated_at) } + '</small>'
  end
end
