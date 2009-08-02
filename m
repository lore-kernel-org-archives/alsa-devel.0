From: Christopher Arndt <chris.arndt@web.de>
Subject: Re: pyalsa: SeqEvent.time strangeness (Was:
 synchronizing queue with MIDI clock events)
Date: Sun, 02 Aug 2009 17:42:35 +0200
Message-ID: <4A75B3EB.5030906@web.de>
References: <4A607468.7010300@web.de>
	<4A65C370.3030205@ladisch.de>	<4A65EADE.70007@web.de>
	<4A733753.60808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 9627424141
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Aug 2009 17:42:25 +0200 (CEST)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 518DA10FA595B
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Aug 2009 17:42:25 +0200 (CEST)
Received: from [87.79.59.178] (helo=minimax.paddyland.lan)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MXdCb-0001zD-00
	for alsa-devel@alsa-project.org; Sun, 02 Aug 2009 17:42:25 +0200
In-Reply-To: <4A733753.60808@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christopher Arndt schrieb:
> I've tested this now and encountered a very strange bevahior of the
> event time set by the queue:
> [...]

Should I report this as a bug then? Is there a special category or
convention for filing pyalsa issues at https://bugtrack.alsa-project.org/ ?


Chris
