package cn.fjzxdz.frame.filter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class WebSiteMeshFilter extends ConfigurableSiteMeshFilter {

    public static final String DECORATOR_URL="/decorator/index";

    /**
     * decoratorPath 第一个参数配置被模板装饰的页面  第二个参数为模板页
     * @param builder
     */
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("**.do", DECORATOR_URL).addExcludedPath(DECORATOR_URL);
    }
}
