    from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=False)
    page = browser.new_page()
    page.goto("https://sei.saude.gov.br/")
    page.wait_for_selector("#selOrgao")
    
    opcoes = page.locator("#selOrgao option").all_text_contents()
    for op in opcoes:
        if op.strip() and op.strip() != "Selecione o órgão":
            print(f'"{op.strip()}"')
    
    input("Pressione Enter para fechar...")
    browser.close()