From: Frank Griffin <ftg@roadrunner.com>
Subject: Re: [REGRESSION bisected] Sound goes too fast due to commit 7b3a177b0
Date: Fri, 16 Apr 2010 06:35:02 -0400
Message-ID: <4BC83D56.5050203@roadrunner.com>
References: <4BC4E812.6050602@tremplin-utc.net>	<s5h633u5zx1.wl%tiwai@suse.de>	<4BC5A566.8060106@tremplin-utc.net>	<s5hy6gqvx9n.wl%tiwai@suse.de>	<4BC782E5.7070900@tremplin-utc.net> <s5hzl13u93u.wl%tiwai@suse.de>
Reply-To: ftg@roadrunner.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzl13u93u.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>, Jaroslav Kysela <perex@perex.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> There is a quirk table in sound/pci/hda_intel.c to check PCI SSID.
> I already added an entry for Frank's machine on sound git tree which
> will be included in the pull request I'm going to send soon.
> (Sorry the mail went outside since Frank's reply was private.)
>   
Not a problem, I just didn't want to spam the others with the rather 
large command output :)
