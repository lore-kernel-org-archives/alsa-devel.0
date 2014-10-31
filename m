From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: CS42L51_I2C depends on I2C
Date: Fri, 31 Oct 2014 14:22:32 -0500
Message-ID: <alpine.DEB.2.10.1410311421240.28816@heelrod>
References: <5453CCCF.5090201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 by alsa0.perex.cz (Postfix) with ESMTP id BB9CD261295
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 20:21:51 +0100 (CET)
In-Reply-To: <5453CCCF.5090201@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Oct 2014, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when CONFIG_I2C is not enabled by making the
> driver depend on I2C.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks for submitting this. Sorry I dropped it
Brian
