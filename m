From: Andrew Morton <akpm@osdl.org>
Subject: Re: patch
 bus_add_device-losing-an-error-return-from-the-probe-method.patch added to
 gregkh-2.6 tree
Date: Tue, 4 Apr 2006 14:22:41 -0700
Message-ID: <20060404142241.66bfdb70.akpm__20019.5773890757$1144187294$gmane$org@osdl.org>
References: <44238489.8090402@keyaccess.nl>
	<1FQquz-2CO-00@press.kroah.org>
	<d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
	<20060404210048.GA5694@suse.de>
	<20060404211505.GA7760@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22377197
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 23:23:38 +0200 (MEST)
In-Reply-To: <20060404211505.GA7760@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: dtor_core@ameritech.net, rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Greg KH <gregkh@suse.de> wrote:
>
> > So, I'm pretty sure that this is safe and should work just fine.  To be
>  > sure, let me go reboot my box with this change on it after I finish this
>  > email :)
> 
>  Yup, things still seem to work properly for me.  The patch will show up
>  in the next -mm for others to beat on...

It was in 2.6.16-mm2 and 2.6.17-rc1-mm1.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
