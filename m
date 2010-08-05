From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc/imx/Kconfig: update to latest changes
 in	Kconfig option names
Date: Thu, 5 Aug 2010 19:26:03 +0100
Message-ID: <20100805182602.GA398@rakim.wolfsonmicro.main>
References: <1280523691-17300-1-git-send-email-eric@eukrea.com>
	<4C59CB3D.6040502@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 193AF245C6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 20:26:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C59CB3D.6040502@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 10:19:09PM +0200, Eric B=E9nard wrote:

> is it possible to get this patch merged for 2.6.36 as the Kconfig
> change is already merged in arch/arm/mach-mx25 and arch/arm/mach-mx3
> ?

This change should have been made as part of the same patch that altered
the Kconfig symbols :/ .  Liam only just acked it yesterday, I've
applied it now.

Please also try to provide meanigful patch descriptions - an explanation
of what had changed and why might've been helpful, for example.
