From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] ALSA: ac97: copy subsys values from the
	PCI device
Date: Thu, 17 Jul 2008 14:31:22 +0200
Message-ID: <487F3B9A.6060304@keyaccess.nl>
References: <487F3A00.6000705@keyaccess.nl> <s5hbq0whf21.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A64D524413
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 14:29:22 +0200 (CEST)
In-Reply-To: <s5hbq0whf21.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-07-08 14:26, Takashi Iwai wrote:

> Well, it is still in that style just for laziness.  Changing to this
> way requires the fix for 2.2/2.4 kernels, adding the chunk to the
> patch, etc.
> 
> Anyway I'll apply it later.

Ah, I see. Don't bother changing it then I'd say. As said, just getting 
acquinted with the code...

Rene.
