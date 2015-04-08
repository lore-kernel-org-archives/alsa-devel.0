From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Audio Jack Out does not work
Date: Wed, 8 Apr 2015 11:07:18 +0300
Message-ID: <20150408080630.GO16501@mwanda>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
 <20150407225642.GN16501@mwanda>
 <CAN8cciY89MH1p7An-RsRkMbFgdKF3OdYGO1hHV594buOpjSuBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id A7594265132
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 10:07:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN8cciY89MH1p7An-RsRkMbFgdKF3OdYGO1hHV594buOpjSuBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, Taylor Smock <smocktaylor@gmail.com>, joe@perches.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2015 at 09:57:13AM +0800, Raymond Yau wrote:
> This patch only change the name of control, you will also need pulseaudio
> patch if you are using pulseaudio
> 
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer?id=aec811798cd883a454b9b5cd82c77831906bbd2d

Ugh...  You are going to make Linus start cursing.

https://lkml.org/lkml/2012/12/23/75

regards,
dan carpenter
