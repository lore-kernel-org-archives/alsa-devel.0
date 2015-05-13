From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: rt5645: Rename HP control
	to	Headphone
Date: Wed, 13 May 2015 15:45:56 +0100
Message-ID: <20150513144556.GJ3480@opensource.wolfsonmicro.com>
References: <1431504912-30698-1-git-send-email-drinkcat@chromium.org>
 <ABFD875FF5FB574BA706497D987D48D7010697AA@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB10E265B93
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 16:45:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7010697AA@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Boichat <drinkcat@chromium.org>, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 11:59:43AM +0000, Bard Liao wrote:
> > -----Original Message-----
> > From: Nicolas Boichat [mailto:drinkcat@chromium.org]
> > Sent: Wednesday, May 13, 2015 4:15 PM
> > To: alsa-devel@alsa-project.org
> > Cc: Bard Liao; Oder Chiou; Koro Chen
> > Subject: [PATCH] ASoC: rt5645: Rename HP control to Headphone
> > 
> > Use the standard name "Headphone" instead of "HP" for better userspace
> > integration.
> > 
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> Acked-by: Bard Liao <bardliao@realtek.com>
> 
> Should we send it to Mark Brown <broonie@kernel.org>?

Yes, he is the maintainer that would apply it so the patch needs
to be sent to him.

Thanks,
Charles
