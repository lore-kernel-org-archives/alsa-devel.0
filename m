From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 3/9] Rename the PSC functions to DMA
Date: Sun, 24 May 2009 08:12:17 -0600
Message-ID: <fa686aa40905240712k62008eacr18860c5a9480d409@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231301.17919.88294.stgit@terra>
	<20090524111512.GD4933@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 168462443C
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 16:12:37 +0200 (CEST)
Received: by gxk2 with SMTP id 2so5298949gxk.8
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 07:12:37 -0700 (PDT)
In-Reply-To: <20090524111512.GD4933@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 5:15 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, May 23, 2009 at 07:13:01PM -0400, Jon Smirl wrote:
>> Rename the functions in the mpc5200 DMA file from i2s based names to dma ones to reflect the file they are in.
>
> I'm OK with both these refactoring patches if Grant is - Grant, if I
> could get your ack I'd like to merge these as soon as possible since
> they're very big changes and it'd cut down on review effort.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
