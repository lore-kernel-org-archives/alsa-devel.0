From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/20] ASoC: S3C: I2Sv2: Reject
	immidiate	register value
Date: Wed, 10 Mar 2010 12:48:56 +0000
Message-ID: <20100310124856.GB6850@sirena.org.uk>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<20100310103203.GE24422@rakim.wolfsonmicro.main>
	<1b68c6791003100427h20a7af3cr750e0de4ce1d1c1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 333E910390A
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:48:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100427h20a7af3cr750e0de4ce1d1c1a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 09:27:10PM +0900, jassi brar wrote:
> s3c-i2s-v2.c is shared only by s3c2412 and s3c64xx.
> smdk64xx_wm8580 and jive_wm8750 already use appropriate values.
> Will add the note in changelog.

That's OK, I'll apply it and add the note myself - no need to resend.
Thanks for checking.
