From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: max98088: Combined DAI
 operations for DAI1 and DAI2.
Date: Thu, 9 Jun 2011 13:07:55 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDEA37AF3@ITSVLEX06.it.maxim-ic.internal>
References: <BANLkTik5m4Guvqq_UtDpCzEjZDdbMM1vZQ@mail.gmail.com>
	<BANLkTi=_3uKgTC1O7KSUPMKEVEGHC1e=Kw@mail.gmail.com>
	<B2150E1E4418E1438554A300EA5040E40DDEA37AB0@ITSVLEX06.it.maxim-ic.internal>
	<20110609190727.GC2821@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam02.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 844F0103888
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 22:07:59 +0200 (CEST)
In-Reply-To: <20110609190727.GC2821@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>, Jin Park <jinyoungp@nvidia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011, Mark Brown wrote:

> I think using the ids is fine; the ids originally come from the driver
> anyway - they're essentially private to it.

Ok thanks.
