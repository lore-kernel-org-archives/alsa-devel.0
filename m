From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix mask for REVID
Date: Thu, 17 Apr 2014 08:49:56 -0500
Message-ID: <alpine.DEB.2.02.1404170849070.9674@heelrod>
References: <1397723743.601.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0071.outbound.protection.outlook.com [207.46.100.71])
 by alsa0.perex.cz (Postfix) with ESMTP id B06172652D1
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 15:49:35 +0200 (CEST)
In-Reply-To: <1397723743.601.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Apr 2014, Axel Lin wrote:

> The REVID mask was changed by commit a1253ef6d3fa
> "ASoC: cs42l51: split i2c from codec driver". Fix it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Sorry about that.

Acked-by: Brian Austin <brian.austin@cirrus.com>
