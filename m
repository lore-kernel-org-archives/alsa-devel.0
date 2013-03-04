From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH] davinci-mcasp: don't configure AFSX
 direction	in DIT mode
Date: Mon, 4 Mar 2013 06:37:37 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3B667@DBDE01.ent.ti.com>
References: <1362134090-8751-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B54264F1D
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 07:37:43 +0100 (CET)
In-Reply-To: <1362134090-8751-1-git-send-email-yegorslists@googlemail.com>
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
To: "yegorslists@googlemail.com" <yegorslists@googlemail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Porter, Matt" <mporter@ti.com>, "zonque@gmail.com" <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 01, 2013 at 16:04:50, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> AFSX won't be used in DIT mode. The related pins are AHCLKX and
> the data pins.
> 

Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
