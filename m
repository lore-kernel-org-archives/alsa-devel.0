From: Nathan Grennan <alsa-devel@cygnusx-1.org>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm -
 Safer	boundary checks"
Date: Sun, 24 May 2009 22:13:38 -0700
Message-ID: <4A1A2902.1010403@cygnusx-1.org>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>	<s5hmy94x0sy.wl%tiwai@suse.de>	<alpine.LNX.2.00.0905231430400.4067@eeebox2.perex-int.cz>	<s5hk547el2j.wl%tiwai@suse.de>	<b24e53350905231434h44fb22e7l8ecd845e0b202f20@mail.gmail.com>
	<s5hprdy536s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from katskitch.com (katskitch.com [67.222.134.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 7013E2462E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 07:13:40 +0200 (CEST)
Received: from proton.cygnusx-1.org (unknown [173.8.189.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by katskitch.com (Postfix) with ESMTPSA id F23F7178079
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 00:13:38 -0500 (CDT)
In-Reply-To: <s5hprdy536s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  > To be sure, did you try the latest alsa-driver snapshot (not 1.0.20)?
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> There are already many fixes since 1.0.20, so...
> 
> Your problem seems not quite as same as the problem stated in this
> thread.  But, anyway testing my patch is helpful.

   I am the original bug reporter to Fedora. Is there anything I can do 
to help troubleshoot this further?
