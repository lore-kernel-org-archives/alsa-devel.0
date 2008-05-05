From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Aloop master volume and oss
Date: Mon, 05 May 2008 08:35:39 -0300
Message-ID: <481EF10B.3010502@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tet.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 547E0243C3
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 13:35:47 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 65082DE806F
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 08:35:43 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id F3694120629
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 08:35:37 -0300 (BRST)
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

Hi!

    I am using aloop and everything works fine, but when I try to 
increase or decrease master volume in alsamixer, oss applications 
continue to play at maximum volume. When I am using a sound card, master 
volume affects oss applications. Is this an aloop configuration issue?

Thanks in advance.
