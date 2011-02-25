From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] eukrea-tlv320: fix platform_name
Date: Fri, 25 Feb 2011 12:58:23 +0000
Message-ID: <20110225125822.GA12705@opensource.wolfsonmicro.com>
References: <1298638066-4049-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B52910396B
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:58:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298638066-4049-1-git-send-email-eric@eukrea.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 25, 2011 at 01:47:46PM +0100, Eric B=E9nard wrote:
> commit f0fba2ad1b6b53d5360125c41953b7afcd6deff0 included a mistake
> on the name of the platform in the snd_soc_dai_link structure.
> =

> Signed-off-by: Eric B=E9nard <eric@eukrea.com>

Applied now, thanks.
