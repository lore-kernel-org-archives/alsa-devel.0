From: John Covici <covici@ccs.covici.com>
Subject: 2.5.6 rtc support broke in alsa
Date: Tue, 19 Mar 2002 01:18:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3ofhlf5ca.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi.  If I try to compile the 2.5.6 kernel with rtc support configured,
I  get an error at line 79 of irqtimer.c complaining that err is
undeclared.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
