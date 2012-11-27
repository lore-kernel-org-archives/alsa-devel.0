From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: mic bias for tlv320aic3x?
Date: Tue, 27 Nov 2012 18:15:27 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1211271808130.20477@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9B526079C
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:15:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by pmeerw.net (Postfix) with ESMTP id 4E616C50123
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:15:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I'd like to enable 2V mic bias on the tlv320aic3x (which offers 2V, 2.5V, 
AVDD, off) -- I'd have expected some control in alsamixer to so, but there 
is none

what is the proper way to implement mic bias selection?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
