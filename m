From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with usb soundcard in kernels > 3.3
Date: Tue, 11 Nov 2014 14:32:31 +0100
Message-ID: <54620FEF.3000201@ladisch.de>
References: <5461EFAF.7040205@amano.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AFA432606B4
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 14:32:32 +0100 (CET)
In-Reply-To: <5461EFAF.7040205@amano.eu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bogdan Veringioiu <bogdan.veringioiu@amano.eu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bogdan Veringioiu wrote:
> The issue I am experiencing is a ~4 seconds delay in playing sound.
> I am reproducing the problem using aplay. The sound play is being
> delayed by more or less 4 seconds from the moment the file is sent
> to the card. I have tested with kernels 3.2 and 3.3, which work
> properly. I have noticed this delay/wait when using kernels 3.15,
> 3.16.

Any messages in the system log when this happens?


Regards,
Clemens
