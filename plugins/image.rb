module Persie
  class HTMLBook
    def image(node)
      align = node.attr?('align') ? node.attr('align') : nil
      float = node.attr?('float') ? node.attr('float') : nil
      style_attr = if align || float
        styles = [align ? %(text-align: #{align}) : nil, float ? %(float: #{float}) : nil].compact
        %( style="#{styles * ';'}")
      end

      width_attr  = node.attr?('width') ? %( width="#{node.attr 'width'}") : nil
      height_attr = node.attr?('height') ? %( height="#{node.attr 'height'}") : nil

      node_target = node.attr('target').sub('images/', '')

      img_element = %(<img src="#{node.image_uri node_target}" alt="#{node.attr 'alt'}"#{width_attr}#{height_attr}/>)
      if (link = node.attr 'link')
        img_element = %(<a href="#{link}">#{img_element}</a>)
      end
      id_attr = node.id ? %( id="#{node.id}") : nil
      classes = ['figure', node.style, node.role].compact
      class_attr = %( class="#{classes * ' '}")
      title_element = node.title? ? %(<div class="figcaption">#{captioned_title_mod_of(node)}</div>) : nil

      %(<div#{id_attr}#{class_attr}#{style_attr}>#{img_element}#{title_element}</div>)
    end
  end
end
