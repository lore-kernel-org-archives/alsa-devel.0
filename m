From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: PATCH - vt1618 7.1 Audio
Date: Wed, 20 Aug 2008 21:54:23 +0200
Message-ID: <48AC766F.1010608@keyaccess.nl>
References: <op.uf5sfuct647oa9@jutz-gnto64> <s5h1w0knl8o.wl%tiwai@suse.de>
	<op.uf646zdn647oa9@jutz-gnto64> <48AC6AFD.6030806@keyaccess.nl>
	<op.uf685pnb647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2880A1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 21:53:14 +0200 (CEST)
In-Reply-To: <op.uf685pnb647oa9@jutz-gnto64>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20-08-08 21:16, John L. Utz III wrote:

> anyway, we can argue about it again after i get a checkpatch
> compliant patch to submit....

Let's get a headstart...

Note that Hungarian is not a private Takashi Iwai or ALSA dislike; it's 
rather specifically against the Linux kernel coding style (although the 
actual CodingStyle document only mentions Hungarian for function names).

Most contributors have had to adjust a few local habits and in the end, 
it's generally worth it. If all is good and well, open source code is 
read many more times than it's written after all and any (significant) 
style inconsistency costs every reader just a little mental hickup. 
Review resources are one of the more scarcely available ones in this 
development process, so a consistent style definitely pays.

Sure, sure, I also try ty get away with things, but Hungarians hickup 
rather loudly.

Rene.
