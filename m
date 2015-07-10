From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Running PJSIP for voip calls in alsa
Date: Fri, 10 Jul 2015 15:39:35 +0200
Message-ID: <559FCB17.2070200@ladisch.de>
References: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 8355A2665C2
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 15:39:36 +0200 (CEST)
In-Reply-To: <SIXPR04MB253E749CD16977CEC4D4120C39F0@SIXPR04MB253.apcprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> we are seeing the below error messages in the PJSIP, Could you please let me know what could be issue ?

I don't know PJSIP.

> The above problem observed with new rootfs (ti sdk 8) but when we tried with old rootfs (ti sdk 7) we are able to make calls with no problem.

Apparently, the driver changed its behaviour in the new kernel.

> If possible, could you please validate this PJSIP version 2.3 on ti sdk 8 BSP's on your EVK kit

I don't have any such TI SDK.


Regards,
Clemens
