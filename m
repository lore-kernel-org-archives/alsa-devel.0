From: Florian Faber <faber@faberman.de>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
 card
Date: Mon, 10 Aug 2009 23:56:27 +0200
Message-ID: <4A80978B.1090508@faberman.de>
References: <h5q3ur$13e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 00B8924640
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 23:56:47 +0200 (CEST)
In-Reply-To: <h5q3ur$13e$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Tim,

> i have the suspicion, that it is related to the combination of the hdsp
> with the cardbus controller of the adapter card ...

Yes. Seen it several times. Get the PCI interface is the only advice I
can give.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
