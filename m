From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Subject: Re: polypaudio renamed to pulseaudio
Date: Wed, 12 Jul 2006 01:12:50 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0607120100020.5284@rhama.deepcore.ngn>
References: <Pine.LNX.4.64.0607112016170.5284@rhama.deepcore.ngn>
	<1152638981.21909.67.camel@mindpipe>
	<Pine.LNX.4.64.0607120004170.5284@rhama.deepcore.ngn>
	<1152653194.21909.85.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from achilles.noc.ntua.gr (achilles.noc.ntua.gr [147.102.222.210])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82B5A17A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 00:14:31 +0200 (MEST)
In-Reply-To: <1152653194.21909.85.camel@mindpipe>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Jul 2006, Lee Revell wrote:

> Yup, that bothers me too.  Also the fact that they seem to have
> developed PulseAudio in complete isolation - they did not as much as
> post to the ALSA list before it was done.  How do we even know it was
> necessary to develop yet another sound server, rather than improve ALSA?

I suppose that PulseAudio has a networked aspect that may be out of the 
scope of ALSA and its design seems more flexible than ESD and less complex 
than JACK, but I don't know how it measures up to other sound servers like 
artsd or NAS. I seem to remember though that the polyp ALSA plugin was 
developed after a bounty from some company, so its necessity may have not 
been examined very objectively - money does have the tendency to twist the 
way people think :-)

> It reeks of NIH.

NIH = ?

> Lee

Regards,

Theodoros Kalamatianos


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
