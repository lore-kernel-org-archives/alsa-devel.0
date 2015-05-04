From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: stereo uac device control over mixer
Date: Mon, 04 May 2015 15:03:50 +0200
Message-ID: <55476E36.4090105@ladisch.de>
References: <1430728456157.40941@geosemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 090A12604E4
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:03:51 +0200 (CEST)
In-Reply-To: <1430728456157.40941@geosemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arijit De <arijit.de@geosemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Arijit De wrote:
> if I add bmaControls(0) and bmaControls(1) with correct bitmap for Mute & Volume support

Show the output of "lsusb -v".


Regards,
Clemens
