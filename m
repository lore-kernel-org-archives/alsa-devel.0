From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Thu, 19 Jan 2006 17:51:27 -0500
Message-ID: <1137711088.3241.9.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8832311F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:51:30 +0100 (MET)
In-Reply-To: <20060119224222.GW21663@redhat.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-01-19 at 17:42 -0500, Dave Jones wrote:
> 
> (The bug is long-since fixed, but the reporters may still have the
>  hardware and be willing to provide feedback to ALSA developers)
> 

The status is we need someone who has the hardware who can add printk's
to the driver to identify what triggers the hang.  It should not be
hard, the OSS driver reportedly works.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328

The bug has been in FEEDBACK state for a long time.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
