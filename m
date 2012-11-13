From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: Sound+USB: deadlock problem
Date: Tue, 13 Nov 2012 09:30:10 +0100
Message-ID: <50A20512.10805@suse.cz>
References: <50A20429.3020109@suse.cz> <s5ha9ulx5xe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha9ulx5xe.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/13/2012 09:28 AM, Takashi Iwai wrote:
> At Tue, 13 Nov 2012 09:26:17 +0100,
> Jiri Slaby wrote:
>>
>> Hello,
>>
>> I've just plugged+unplugged+plugged my USB audio card and the audio
>> subsystem got stuck:
> 
> Which kernel?  If it's older than 3.7-rc5, could you try 3.7-rc5?

Oh, forgot to mention:
3.7.0-rc5-next-20121112_64+

thanks,
-- 
js
suse labs
