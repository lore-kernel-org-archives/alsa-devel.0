From: Richard Bown <bownie@bownie.com>
Subject: Re: Quick SBLive/AWE32 synth question
Date: Thu, 1 Aug 2002 10:08:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208011008.38121.bownie@bownie.com>
References: <200207301624.02609.bownie@bownie.com> <200207311902.02690.bownie@bownie.com> <3D486CCD.2040600@baydenet.com.br>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D486CCD.2040600@baydenet.com.br>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Taupter wrote:

[ALSA sequencers and that repeating note problem]

> try noteedit.

Of course!  Ok so, NoteEdit worked fine and so I reinspected our code and lo
and behold found a little bugette with our note off matrix.  Now fixed.

Sorry for the false alarm.

B


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
