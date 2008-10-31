From: cocala <syy.wxd@gmail.com>
Subject: How to set the original/target sample rate?
Date: Fri, 31 Oct 2008 16:31:43 +0800
Message-ID: <458a17f90810310131r5105dc88ga2dadd4641ee5f7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 6317424441
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 09:31:45 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1017035rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 01:31:44 -0700 (PDT)
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

My audio codec can perform sample rate convert. Then how to tell codec
driver the original sample rate and target sample rate through alsa library
interface?
