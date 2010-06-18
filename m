From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
	board
Date: Fri, 18 Jun 2010 01:56:37 +0100
Message-ID: <20100618005637.GA3333@opensource.wolfsonmicro.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01D5910380E
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 02:56:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276782241-9407-1-git-send-email-eric@eukrea.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 17, 2010 at 03:44:01PM +0200, Eric B=E9nard wrote:
> * tdm slot has to be configured to get sound working on i.MX25
> =

> Signed-off-by: Eric B=E9nard <eric@eukrea.com>

Applied but I had to hand apply the Kconfig update, please check that it
applied correctly.
