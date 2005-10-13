From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: How to compile c programs with ALSA API
Date: Thu, 13 Oct 2005 17:23:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0510131721580.18256@denise.shiny.it>
References: <329214867.00900@mails.tsinghua.edu.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <329214867.00900@mails.tsinghua.edu.cn>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: zhouc <zhouc@mails.tsinghua.edu.cn>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 13 Oct 2005, zhouc wrote:

> how can I compile it ?

cc -lasound soundplay.c -o soundplay


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
