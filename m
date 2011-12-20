From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver
 forboards using ALC5332 codec
Date: Tue, 20 Dec 2011 11:09:45 +0000
Message-ID: <20111220110945.GI2866@opensource.wolfsonmicro.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
	<CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
	<1681052.3aIfuFPFms@fb07-iapwap2>
	<CALq1K=Lf60Jsk08oA2WjkvhsBp013qtrEYvUsqBtf2ys9yYD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 238A5103B02
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 12:09:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=Lf60Jsk08oA2WjkvhsBp013qtrEYvUsqBtf2ys9yYD7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@nvidia.com>, "lrg@ti.com" <lrg@ti.com>, Marc Dietrich <marvin24@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2011 at 01:05:50PM +0200, Leon Romanovsky wrote:
> On Tue, Dec 20, 2011 at 10:47, Marc Dietrich <marvin24@gmx.de> wrote:

> > If you have updates to other files beside the audio stuff (nvec or board stuff), you
> > need to CC the relevant maintainers (see scripts/get_maintainer.pl).

> Different trees have different file versions, this is why i'm asking
> "on which tree do I base my patches?"

It depends on what you're doing, what (if anything) the interdependencies
are and sometimes where we are in the development cycle.
