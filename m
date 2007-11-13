From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: E-mu 1212M/1820M/1616M development
Date: Tue, 13 Nov 2007 14:15:52 +0100
Message-ID: <200711131415.52229.c.fertr@gmail.com>
References: <47376DE9.5000904@gmail.com> <47378776.6050403@superbug.co.uk>
	<4738D545.3060800@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from praha.adaptech.cz (r9bz245.net.upc.cz [78.102.77.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 58667244E4
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 14:15:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by praha.adaptech.cz (Postfix) with ESMTP id 43771AFAA0
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 14:17:22 +0100 (CET)
Received: from praha.adaptech.cz ([127.0.0.1])
	by localhost (praha.adaptech.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHtcwjxuigOD for <alsa-devel@alsa-project.org>;
	Tue, 13 Nov 2007 14:17:16 +0100 (CET)
Received: from [192.168.0.200] (unknown [192.168.0.200])
	by praha.adaptech.cz (Postfix) with ESMTP id 8AD15AFA2E
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 14:17:16 +0100 (CET)
In-Reply-To: <4738D545.3060800@superbug.co.uk>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne Monday 12 of November 2007 23:35:49 James Courtier-Dutton napsal(a):
> Comments added into hg repository, in emu10k1.h
> alsa changeset: 5529

Thanks. It helped a lot. After quick hack I can use S/PDIF on microdock :) Now 
I'm thinking about an elegant way how to handle different mixer schemes in 
emumixer. Any ideas?  

---
Ctirad
