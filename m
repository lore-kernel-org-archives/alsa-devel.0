From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs42l56: Fix new value argument
 in snd_soc_update_bits calls
Date: Fri, 23 May 2014 02:14:32 +0000
Message-ID: <832DD12F-2685-4B9B-AD5F-CF0FEB999A52@cirrus.com>
References: <1400806302.21451.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A64264FE3
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 14:36:43 +0200 (CEST)
In-Reply-To: <1400806302.21451.1.camel@phoenix>
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



> On May 22, 2014, at 19:51, "Axel Lin" <axel.lin@ingics.com> wrote:
> 
> The new value argument needs proper shift to match the mask bit fields.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I like this Axel,
I will test Monday

Thanks again,
Brian
