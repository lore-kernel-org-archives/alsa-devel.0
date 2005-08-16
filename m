From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compulab sound device
Date: Tue, 16 Aug 2005 09:22:28 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508160918350.11998-100000@studcom.urz.uni-halle.de>
References: <20050816070454.27070.qmail@web54607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050816070454.27070.qmail@web54607.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chow Raymond wrote:
> Im not sure how to use CVS. Anyway I followed what you
> suggested which is to copy the content in
> alsa-kernel/arm to kernel's sound/arm. However, when i
> rebuild the kernel, i face a missing header file.
>
> asm/arch/audio.h: No such file or directory

It seems your kernel is too old.
A newer kernel would have a newer ALSA, too.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
