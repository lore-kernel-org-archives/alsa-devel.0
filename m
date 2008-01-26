From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Broken seq
Date: Sat, 26 Jan 2008 12:50:58 +0000
Message-ID: <200801261250.58032.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 91AD6243DC
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 13:32:23 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Can someone help with this...

During repeated testing of MIDI, something has broken the seq system, so when 
loading previously working sound drivers, I get a message:

	/proc/asound/seq/clients   File not found

(or similar) and sure enough it is not there.

Why has it gone and how can I get it back?

Thanks  Alan
