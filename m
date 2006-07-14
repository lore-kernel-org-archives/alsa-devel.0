From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: ALC260 no sound output on Kernel 2.6.17.1
Date: Fri, 14 Jul 2006 10:35:32 +0100
Message-ID: <44B76564.8000703@onelan.co.uk>
References: <449BE867.1070500@onelan.co.uk> <s5hd5d09cy5.wl%tiwai@suse.de>	
	<449C0913.20504@onelan.co.uk> <1152831906.2961.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E2E319C
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 11:35:52 +0200 (MEST)
In-Reply-To: <1152831906.2961.0.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Fri, 2006-06-23 at 16:30 +0100, Barry Scott wrote:
>   
>>> This should have been fixed in 1.0.12rc1.
>>>   
>>>       
>> Its the user land code that has the bug not the kernel drivers then? 
>>     
>
> Have you tried the ALSA 1.0.12rc1 kernel drivers yet?
>
> Lee
>   
Yes it works. Something in the ALSA 1.0.12rc1 fixes it. I updated drivers,
lib and utils.

I was waiting for a reply to my messages asking which package I needed to
install. When no further info was forthcoming I explored all the kits.

I was surprised to see 2.6 drivers in the drivers package. All the previous
drivers packages tell me the drivers are shipped with linux kernel. Luck
I checked.

Barry



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
