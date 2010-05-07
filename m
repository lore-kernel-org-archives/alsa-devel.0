From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Fri, 7 May 2010 11:22:21 +0100
Message-ID: <20100507102221.GB27795@sirena.org.uk>
References: <1272351431-3981-1-git-send-email-jassi.brar@samsung.com>
	<20100505143046.GA9530@rakim.wolfsonmicro.main>
	<v2u1b68c6791005061833r9a98cbbbk771cce705d82a5cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1093224513
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 12:22:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <v2u1b68c6791005061833r9a98cbbbk771cce705d82a5cd@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 10:33:39AM +0900, jassi brar wrote:
> On Wed, May 5, 2010 at 11:30 PM, Mark Brown

> > Actually, this is the first patch that seems to have an issue so I've
> > applied the patches up till this point.

> That is strange, because I am able to cleanly apply these 11 patches
> against commit  cb7cf44c880aeb8caf8 of for-2.6.35
> Could you please try again?

I did try several times, including using a three way merge.  It's
possible some damage was introduced in the mail path (though it'd be a
bit odd given that everything else might work) so a simple resend might
do the trick?
