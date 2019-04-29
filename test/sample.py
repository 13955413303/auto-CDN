import time
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from pyvirtualdisplay import Display
from selenium.webdriver.chrome.options import Options
from pyvirtualdisplay import Display


options = webdriver.ChromeOptions()
#options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-gpu')
options.add_argument('--disable-dev-shm-usage')
options.add_argument('--ignore-certificate-errors')
options.add_experimental_option("excludeSwitches",["ignore-certificate-errors"])

browser = webdriver.Chrome(chrome_options=options)

display = Display(visible=0, size=(800, 600))
display.start()


# 10.67.117.130
# 10.67.116.170
def cfg():
    above = browser.find_element_by_xpath("//div[@class='top-bar-right']/ul/li/a")
    ActionChains(browser).move_to_element(above).perform()

    time.sleep(1)
    login = browser.find_element_by_xpath("//div[@class='top-bar-right']/ul/li//ul//a")
    login.click()

    time.sleep(1)
    input = browser.find_element_by_xpath("//form/div[@class='input-group']/input[@class='input-group-field']")
    input.clear()
    input.send_keys(username)

    submit = browser.find_element_by_xpath("//form/input[@class='button expanded']")
    submit.send_keys(Keys.ENTER)



def pplay(id):
    time.sleep(1)
    play = browser.find_element_by_xpath("//table[@class='unstripped']/tbody/tr[" + id + "]/td/a/img")
    ActionChains(browser).double_click(play).perform()
    if id == '1':
        ActionChains(browser).double_click(play).perform()


def checkPlay():
    js_next = 'return document.getElementsByTagName("video")[0].ended;'
    while True:
        result = browser.execute_script(js_next)
        if result:
            break
        else:
            time.sleep(1)


userlist = ['media', 'root']

browser.get('https://10.67.117.130')
#details_button = browser.find_element_by_id('details-button')
#details_button.click()
#proceed_link = browser.find_element_by_id('proceed-link')
#proceed_link.click()
username = userlist[0]
cfg()

for i in range(1, len(userlist)):
    username = userlist[i]
    js = 'window.open("https://10.67.117.130/");'
    browser.execute_script(js)
    browser.switch_to_window(browser.window_handles[-1])
    cfg()

time.sleep(1)
playstr = browser.find_element_by_xpath("//tbody/tr/td[3]/table[@class='unstripped']/tbody").text
playlist = playstr.split('\n')

print('\033[33;0m------------playlist--------------\033[0m')
for i in range(1, len(playlist) + 1):
    print('%2d%s%s' % (i, '-----', playlist[i - 1]))
print('\033[33;0m------------endline---------------\033[0m')

number = 1
flay = 1
while number <= len(playlist):
    print('\033[32;0m' + 'Auto playing %2d-----%s ......' % (number, playlist[number - 1]) + '\033[0m')
    for handle in browser.window_handles:
        browser.switch_to_window(handle)
        pplay(str(number))
    checkPlay()
    number += 1
    if number == len(playlist)+1:
        print('------------part%d----------'%flag)
        flag += 1
        number = 1

