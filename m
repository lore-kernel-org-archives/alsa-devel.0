From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Re: Native Sample Format
Date: Sun, 14 Apr 2002 14:08:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0204141404170.14691-100000@yme.mo.himolde.no>
References: <3CB93DE0.C3AE15C9@t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CB93DE0.C3AE15C9@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank Uepping <Frank.Uepping@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Apr 2002, Frank Uepping wrote:
>This is not a ALSA specific question (so I apologize if this is
>inappropriate)
>and directed to driver programmers.
>Are the sample formats ALAW and MULAW supported by all soundcards in
>Hardware?
>What is a native sample format supported by all soundcards?

There is none, I suspect. Some pro sundcards support only one sample
format (24bit) in hardware, some old cards do only 8bit in hardware... and
A/MULAW is not supported in hardware by all cards, no.

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.
