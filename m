From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc/imx/Kconfig: update to latest changes
	in	Kconfig option names
Date: Thu, 5 Aug 2010 22:44:22 +0100
Message-ID: <BBE15144-DE06-49B1-A430-023D683BFB23@opensource.wolfsonmicro.com>
References: <1280523691-17300-1-git-send-email-eric@eukrea.com>
	<4C59CB3D.6040502@eukrea.com>
	<20100805182602.GA398@rakim.wolfsonmicro.main>
	<4C5B0D10.3020606@eukrea.com>
	(sfid-20100805_201224_311433_B7A833E5)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4576C10391A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 23:44:24 +0200 (CEST)
In-Reply-To: <4C5B0D10.3020606@eukrea.com>
	(sfid-20100805_201224_311433_B7A833E5)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 5 Aug 2010, at 20:12, Eric B=E9nard wrote:

> Le 05/08/2010 20:26, Mark Brown a =E9crit :
>> On Wed, Aug 04, 2010 at 10:19:09PM +0200, Eric B=E9nard wrote:
>> =

>>> is it possible to get this patch merged for 2.6.36 as the Kconfig
>>> change is already merged in arch/arm/mach-mx25 and arch/arm/mach-mx3
>>> ?
>> =

>> This change should have been made as part of the same patch that altered
>> the Kconfig symbols :/ .
> OK I didn't know how to handle this as one part is in arm and the other i=
n sound.

Send one patch to both places and let the maintainers figure out what the b=
est way to merge it is.
