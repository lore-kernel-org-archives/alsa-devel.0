From: Dennis van der Meer <dvdmeer@wanadoo.nl>
Subject: Re: Terratec Aureon Space
Date: Sun, 31 Aug 2003 12:04:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030831120401.021c6f80@192.168.10.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks, it worked like a charm.
Now all I have to do is get kde to recognize it so I can have music through 
kde also but that will be
a different matter altogether.
Thank you very much for your help. It has been almost 6 months without 
sound in Linux so I can finally
switch back again permanently.

>>i had the same problem, so i read your interesting conversation with 
>>Takashi Iwai. I think this lead me to a first solution.
>>Here it is in brief:
>>........
>>.......
>>I hope this works for you too. If so please tell Takashi Iwai. Thank you.
>>
>>PS: If you like to know why this change of the value helps, let me tell you:
>>The bit 0 in EEPROM-register CCS07 says that an optical output is 
>>physically implemented. If not set the red light will not be switched on.
>>This behavior is documented in a file called Envy24HT.pdf which I 
>>occasionally found in the internet.
>
>Thanks,
>
>Dennis van der Meer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
