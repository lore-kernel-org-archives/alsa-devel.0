From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Thu, 19 Jan 2006 22:11:03 +0000
Message-ID: <1137708663.8471.67.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45929141
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:11:09 +0100 (MET)
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id D0B4399212
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:11:08 +0100 (MET)
In-Reply-To: <1137696885.32195.12.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Iau, 2006-01-19 at 13:54 -0500, Lee Revell wrote:
> /*
>  *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
>  *
>  *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
>  *
> 
> Why was a new OSS driver written and accepted at such a late date, when
> OSS was already deprecated?

Because
	1.	I wanted the support
	2.	It was needed for my employers systems which like everyone else were
still OSS at the time

Welcome to the *real world*

Alan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
