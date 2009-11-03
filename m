From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200
	AC97+I2S	audio support.
Date: Tue, 3 Nov 2009 11:13:32 +0000
Message-ID: <20091103111331.GA29431@sirena.org.uk>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	<1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	<20091103104337.GA26068@opensource.wolfsonmicro.com>
	<f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D62524445
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 12:13:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2009 at 12:00:19PM +0100, Manuel Lauss wrote:
> On Tue, Nov 3, 2009 at 11:43 AM, Mark Brown

> > This looks good for me. ?The patch touches both ASoC and MIPS trees -
> > I'm happy with it being merged though either.

> Thanks for having a look!  I'd rather have it go through the MIPS tree,
> otherwise there's a higher chance of merge conflicts.

That's fine for me:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

and if there's any merge issues we can sort them out later.
