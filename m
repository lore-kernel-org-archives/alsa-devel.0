From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l73: Fix mask for setting
	CS42L73_SP_3ST bit
Date: Thu, 23 Jul 2015 10:36:24 +0000
Message-ID: <AEA6C991-1655-4CE8-B28F-F3680F5C4787@cirrus.com>
References: <1437611217.6620.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CE2D260711
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 12:36:26 +0200 (CEST)
In-Reply-To: <1437611217.6620.2.camel@ingics.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



> On Jul 22, 2015, at 19:27, Axel Lin <axel.lin@ingics.com> wrote:
> 
> CS42L73_SP_3ST is BIT(7), so the mask field is wrong. Fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks 
