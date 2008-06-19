From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] ad1848: replace duplicated constants
 in cs4231
Date: Thu, 19 Jun 2008 11:15:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806191115300.1798@tm8103-a.perex-int.cz>
References: <20080615124128.48486ddc.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.61.0806191030140.1798@tm8103-a.perex-int.cz>
	<s5hwskl94bu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 611DE24364
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 11:15:49 +0200 (CEST)
In-Reply-To: <s5hwskl94bu.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jun 2008, Takashi Iwai wrote:

> At Thu, 19 Jun 2008 10:31:41 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Sun, 15 Jun 2008, Krzysztof Helt wrote:
> > 
> > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > 
> > > Use AD1848 register names in the cs4231 library as well.
> > > 
> > > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Applied to ALSA repo. Thanks.
> 
> This patch shouldn't be applied to the upstream yet.  Please revert.
> 
> See the thread on [PATCH 1/2] ad1848: separate header for registers
> definition.

Oops. I missed it. Removed. Thanks.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
